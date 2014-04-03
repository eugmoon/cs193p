//
//  PersonListViewController.m
//  foo2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PersonListViewController.h"
#import "PhotoListViewController.h"
#import "Person.h"
#import "Photo.h"


@implementation PersonListViewController

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
		flickrFetcher = [FlickrFetcher sharedInstance];
		
		UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
		self.tabBarItem = item; 
		[item release];
		UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showSetFlickrUsername)];
		UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateRecentPhotos)];
		self.navigationItem.leftBarButtonItem = addButton;
		self.navigationItem.rightBarButtonItem = updateButton;
		[addButton release];
		[updateButton release];
    }
    return self;
}

- (void)updateRecentPhotos {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSArray *recentPhotoArray = [flickrFetcher recentGeoTaggedPhotos];
	NSManagedObjectContext *context = [flickrFetcher managedObjectContext];
	if (!context) {
		// Handle the error.
		NSLog(@"Failed to initialize context for Core Data!");
	}
	NSFetchRequest *photoRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *photoEntity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
	[photoRequest setEntity:photoEntity];
	NSError *photoError;
	Photo *photo = nil;
	for (NSDictionary *photoDictionary in recentPhotoArray) {
		NSPredicate *photoPredicate = [NSPredicate predicateWithFormat:@"photoid like[c] %@", [NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"id"]]];
		NSArray *photoFetchResultsArray = [NSArray arrayWithArray:[flickrFetcher fetchManagedObjectsForEntity:@"Photo" withPredicate:photoPredicate]];
		NSFetchRequest *personRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *personEntity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
		[personRequest setEntity:personEntity];
		NSError *personError;
		Person *person = nil;
		if ([photoFetchResultsArray count] <= 0) {
			NSPredicate *personPredicate = [NSPredicate predicateWithFormat:@"owner like[c] %@", [NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			NSArray *personFetchResultsArray = [NSArray arrayWithArray:[flickrFetcher fetchManagedObjectsForEntity:@"Person" withPredicate:personPredicate]];
			if ([personFetchResultsArray count] > 0) {
				person = (Person *)[personFetchResultsArray objectAtIndex:0];
			}
			else {
				person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
				[person setOwner:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			}
			photo = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
			[photo setFarm:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"farm"]]];
			[photo setOwner:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			[photo setPhotoid:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"id"]]];
			[photo setSecret:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"secret"]]];
			[photo setServer:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"server"]]];
			[photo setPhotodatalarge:[flickrFetcher dataForPhotoID:[photo photoid] fromFarm:[photo farm] onServer:[photo server] withSecret:[photo secret] inFormat:FlickrFetcherPhotoFormatLarge]];
			[photo setPhotodatasquare:[flickrFetcher dataForPhotoID:[photo photoid] fromFarm:[photo farm] onServer:[photo server] withSecret:[photo secret] inFormat:FlickrFetcherPhotoFormatSquare]];
			[photo setTitle:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"title"]]];
			NSDictionary *locationDictionary = [flickrFetcher locationForPhotoID:[photo photoid]];
			[photo setLatitude:[locationDictionary objectForKey:@"latitude"]];
			[photo setLongitude:[locationDictionary objectForKey:@"longitude"]];
			
			[person addPhotoSetObject:photo];
			[photo setPerson:person];
		}
		[personRequest release];
		personError = nil;
	}
	[photoRequest release];
	photoError = nil;
	if (![context save:&photoError]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", photoError, [photoError userInfo]);
		//			abort();
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self.delegate refreshTableView];
}

- (void)showSetFlickrUsername {
	UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] initWithNibName:@"UserDetailViewController" bundle:[NSBundle mainBundle]];
	userDetailViewController.delegate = self;
	[self presentModalViewController:userDetailViewController animated:YES];
	[userDetailViewController release];
}

- (void)didSetFlickrUsername:(NSString *)username {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSArray *userPhotoArray = [flickrFetcher photosForUser:username];
	NSManagedObjectContext *context = [flickrFetcher managedObjectContext];
	if (!context) {
		// Handle the error.
		NSLog(@"Failed to initialize context for Core Data!");
	}
	NSFetchRequest *photoRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *photoEntity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
	[photoRequest setEntity:photoEntity];
	NSError *photoError;
	Photo *photo = nil;
	for (NSDictionary *photoDictionary in userPhotoArray) {
		NSPredicate *photoPredicate = [NSPredicate predicateWithFormat:@"photoid like[c] %@", [NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"id"]]];
		NSArray *photoFetchResultsArray = [NSArray arrayWithArray:[flickrFetcher fetchManagedObjectsForEntity:@"Photo" withPredicate:photoPredicate]];
		NSFetchRequest *personRequest = [[NSFetchRequest alloc] init];
		NSEntityDescription *personEntity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
		[personRequest setEntity:personEntity];
		NSError *personError;
		Person *person = nil;
		if ([photoFetchResultsArray count] <= 0) {
			NSPredicate *personPredicate = [NSPredicate predicateWithFormat:@"owner like[c] %@", [NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			NSArray *personFetchResultsArray = [NSArray arrayWithArray:[flickrFetcher fetchManagedObjectsForEntity:@"Person" withPredicate:personPredicate]];
			if ([personFetchResultsArray count] > 0) {
				person = (Person *)[personFetchResultsArray objectAtIndex:0];
			}
			else {
				person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
				[person setOwner:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			}
			photo = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
			[photo setFarm:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"farm"]]];
			[photo setOwner:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			[photo setPhotoid:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"id"]]];
			[photo setSecret:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"secret"]]];
			[photo setServer:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"server"]]];
			[photo setPhotodatalarge:[flickrFetcher dataForPhotoID:[photo photoid] fromFarm:[photo farm] onServer:[photo server] withSecret:[photo secret] inFormat:FlickrFetcherPhotoFormatLarge]];
			[photo setPhotodatasquare:[flickrFetcher dataForPhotoID:[photo photoid] fromFarm:[photo farm] onServer:[photo server] withSecret:[photo secret] inFormat:FlickrFetcherPhotoFormatSquare]];
			[photo setTitle:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"title"]]];
			NSDictionary *locationDictionary = [flickrFetcher locationForPhotoID:[photo photoid]];
			[photo setLatitude:[locationDictionary objectForKey:@"latitude"]];
			[photo setLongitude:[locationDictionary objectForKey:@"longitude"]];
			
			[person addPhotoSetObject:photo];
			[photo setPerson:person];
		}
		[personRequest release];
		personError = nil;
	}
	[photoRequest release];
	photoError = nil;
	if (![context save:&photoError]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", photoError, [photoError userInfo]);
		//			abort();
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self.delegate refreshTableView];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSFetchedResultsController *fetchedResultsController = [flickrFetcher fetchedResultsControllerForEntity:@"Person" withPredicate:nil];
	NSError *error;
	[fetchedResultsController performFetch:&error];
	
	return [[[fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSFetchedResultsController *fetchedResultsController = [flickrFetcher fetchedResultsControllerForEntity:@"Person" withPredicate:nil];
	NSError *error;
	[fetchedResultsController performFetch:&error];
	
	Person *person = [fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [flickrFetcher usernameForUserID:[person owner]]];
	NSSet *photoSet = [person photoSet];
	Photo *photo = [photoSet anyObject];
	UIImage *photoImage = [UIImage imageWithData:[photo photodatasquare]];
	cell.imageView.image = photoImage;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	PhotoListViewController *photoListViewController = [[PhotoListViewController alloc] initWithStyle:UITableViewStylePlain];
	NSFetchedResultsController *fetchedResultsController = [flickrFetcher fetchedResultsControllerForEntity:@"Person" withPredicate:nil];
	NSError *error;
	[fetchedResultsController performFetch:&error];
	Person *person = [fetchedResultsController objectAtIndexPath:indexPath];
	photoListViewController.person = person;
	
	[self.navigationController pushViewController:photoListViewController animated:YES];
	[photoListViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

