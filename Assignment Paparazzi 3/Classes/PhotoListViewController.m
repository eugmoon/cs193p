//
//  PhotoListViewController.m
//  foo2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoDetailViewController.h"
#import "Photo.h"


@implementation PhotoListViewController

@synthesize person;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
		flickrFetcher = [FlickrFetcher sharedInstance];
		
		UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
		self.tabBarItem = item; 
		[item release];
    }
    return self;
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

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
	NSPredicate *predicate;
	if (person != nil)
		predicate = [NSPredicate predicateWithFormat:@"person == %@", person];
	else
		predicate = nil;
	NSFetchedResultsController *fetchedResultsController = [flickrFetcher fetchedResultsControllerForEntity:@"Photo" withPredicate:predicate];
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
//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Set up the cell...
	NSPredicate *predicate = nil;
	if (person != nil)
		predicate = [NSPredicate predicateWithFormat:@"person == %@", person];
	else
		predicate = nil;
	NSFetchedResultsController *fetchedResultsController = [flickrFetcher fetchedResultsControllerForEntity:@"Photo" withPredicate:predicate];
	NSError *error;
	[fetchedResultsController performFetch:&error];
	Photo *photo = [fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [photo title]];
	cell.imageView.image = [UIImage imageWithData:[photo photodatasquare]];
//	cell.detailTextLabel.text = [NSString stringWithFormat:@"%f, %f", [[photo latitude] doubleValue], [[photo longitude] doubleValue]];
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	PhotoDetailViewController *photoDetailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:[NSBundle mainBundle]];
	
	NSPredicate *predicate = nil;
	if (person != nil)
		predicate = [NSPredicate predicateWithFormat:@"person == %@", person];
	else
		predicate = nil;
	NSFetchedResultsController *fetchedResultsController = [flickrFetcher fetchedResultsControllerForEntity:@"Photo" withPredicate:predicate];
	NSError *error;
	[fetchedResultsController performFetch:&error];
	Photo *photo = [fetchedResultsController objectAtIndexPath:indexPath];
	photoDetailViewController.photo = photo;
	
	[self.navigationController pushViewController:photoDetailViewController animated:YES];
	[photoDetailViewController release];
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
	person = nil;
	
    [super dealloc];
}


@end

