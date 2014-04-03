//
//  PersonListViewController.h
//  foo2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"
#import "UserDetailViewController.h"

@protocol PersonListViewControllerDelegate;

@interface PersonListViewController : UITableViewController <UserDetailViewControllerDelegate> {
	FlickrFetcher *flickrFetcher;
	id<PersonListViewControllerDelegate> delegate;
}

@property (assign) id<PersonListViewControllerDelegate> delegate;

- (void)showSetFlickrUsername;
- (void)updateRecentPhotos;

@end

@protocol PersonListViewControllerDelegate <NSObject>

- (void)refreshTableView;

@end