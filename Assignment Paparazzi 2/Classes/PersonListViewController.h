//
//  PersonListViewController.h
//  foo2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"


@interface PersonListViewController : UITableViewController {
	FlickrFetcher *flickrFetcher;
}

@end
