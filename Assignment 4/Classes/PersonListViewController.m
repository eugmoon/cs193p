//
//  PersonListViewController.m
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PersonListViewController.h"


@implementation PersonListViewController

@synthesize photoArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
		self.tabBarItem = item; 
		[item release];
    }
    return self;
}

- (void)viewDidLoad {
	int i = 0;
	ownerStringArray = [[NSMutableArray alloc] init];
	
	for (NSDictionary *photoMetadata in photoArray) {
		NSString *ownerString = [photoMetadata objectForKey:@"owner"];
		if (![ownerStringArray containsObject:ownerString]) {
			[ownerStringArray addObject:ownerString];
			UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [photoMetadata objectForKey:@"filename"]]];
			CGRect frame = CGRectMake(20, (20 + i*95), 100, 75);
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
			imageView.image = image;
			imageView.contentMode = UIViewContentModeScaleAspectFill;
			[self.view addSubview:imageView];
			[imageView release];
			
			frame = CGRectMake(128, (47 + i*95), 92, 21);
			UILabel *label = [[UILabel alloc] initWithFrame:frame];
			label.text = [NSString stringWithFormat:@"%@", ownerString];
			[self.view addSubview:label];
			[label release];
			
			i++;
		}
	}
	
	if (i == 4)
		;
	else if(i == 3)
		fourthButton.hidden = YES;
	else if(i == 2) {
		thirdButton.hidden = YES;
		fourthButton.hidden = YES;
	}
	else if(i == 1) {
		secondButton.hidden = YES;
		thirdButton.hidden = YES;
		fourthButton.hidden = YES;
	}
	else if(i == 0) {
		firstButton.hidden = YES;
		secondButton.hidden = YES;
		thirdButton.hidden = YES;
		fourthButton.hidden = YES;
	}
}

- (IBAction)viewPhotoList:(id)sender {
	int i = 1;
	NSMutableString *selectedOwner;
	
	for (NSString *ownerString in ownerStringArray) {
		if ([sender tag] == i) {
			selectedOwner = [NSString stringWithFormat:@"%@", ownerString];
		}
		i++;
	}
	
	NSMutableArray *newPhotoArray = [[NSMutableArray alloc] init];
	for (NSDictionary *photoMetadata in photoArray) {
		if ([selectedOwner isEqualToString:[photoMetadata objectForKey:@"owner"]]) {
			NSDictionary *tempDictionary = [photoMetadata copy];
			[newPhotoArray addObject:tempDictionary];
			[tempDictionary release];
		}
	}
	
	PhotoListViewController *photoListViewController = [[PhotoListViewController alloc] initWithNibName:@"PhotoListViewController" bundle:[NSBundle mainBundle]];
	photoListViewController.photoArray = newPhotoArray;
	photoListViewController.title = [NSString stringWithFormat:@"%@'s Photos", selectedOwner];
	[self.navigationController pushViewController:photoListViewController animated:YES];
	[photoListViewController release];
	[newPhotoArray release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[ownerStringArray release];
	[photoArray release];
	
    [super dealloc];
}


@end
