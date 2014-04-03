//
//  PhotoListViewController.h
//  foo2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"
#import "Person.h"


@interface PhotoListViewController : UITableViewController {
	FlickrFetcher *flickrFetcher;
//	NSFetchedResultsController *fetchedResultsController;
	Person *person;
}

@property (nonatomic, retain) Person *person;

@end
