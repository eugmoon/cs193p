//
//  PhotoListViewController.m
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PhotoListViewController.h"


@implementation PhotoListViewController

@synthesize photoArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:0];
		self.tabBarItem = item; 
		[item release];
    }
    return self;
}

- (void)viewDidLoad {
	int i = 0;
	
	for (NSDictionary *photoMetadata in photoArray) {
		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [photoMetadata objectForKey:@"filename"]]];
		CGRect frame = CGRectMake(20, (20 + i*53), 60, 45);
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
		imageView.image = image;
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		[self.view addSubview:imageView];
		[imageView release];
		
		frame = CGRectMake(88, (20 + i*53), 132, 21);
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
		titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
		titleLabel.text = [NSString stringWithFormat:@"%@", [photoMetadata objectForKey:@"phototitle"]];
		[self.view addSubview:titleLabel];
		[titleLabel release];
		
		frame = CGRectMake(88, (44 + i*53), 132, 21);
		UILabel *ownerLabel = [[UILabel alloc] initWithFrame:frame];
		ownerLabel.textColor = [UIColor grayColor];
		ownerLabel.text = [NSString stringWithFormat:@"%@", [photoMetadata objectForKey:@"owner"]];
		[self.view addSubview:ownerLabel];
		[ownerLabel release];
		i++;
	}

	if (i == 7)
		;
	else if(i == 6) {
		seventhButton.hidden = YES;
	}
	else if(i == 5) {
		sixthButton.hidden = YES;
		seventhButton.hidden = YES;
	}
	else if(i == 4) {
		fifthButton.hidden = YES;
		sixthButton.hidden = YES;
		seventhButton.hidden = YES;
	}
	else if(i == 3) {
		fourthButton.hidden = YES;
		fifthButton.hidden = YES;
		sixthButton.hidden = YES;
		seventhButton.hidden = YES;
	}
	else if(i == 2) {
		thirdButton.hidden = YES;
		fourthButton.hidden = YES;
		fifthButton.hidden = YES;
		sixthButton.hidden = YES;
		seventhButton.hidden = YES;
	}
	else if(i == 1) {
		secondButton.hidden = YES;
		thirdButton.hidden = YES;
		fourthButton.hidden = YES;
		fifthButton.hidden = YES;
		sixthButton.hidden = YES;
		seventhButton.hidden = YES;
	}
	else if(i == 0) {
		firstButton.hidden = YES;
		secondButton.hidden = YES;
		thirdButton.hidden = YES;
		fourthButton.hidden = YES;
		fifthButton.hidden = YES;
		sixthButton.hidden = YES;
		seventhButton.hidden = YES;
	}
}

- (IBAction)viewPhotoList:(id)sender {
	int i = 1;
	
	for (NSDictionary *photoMetadata in photoArray) {
		if ([sender tag] == i) {
			PhotoDetailViewController *photoDetailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:[NSBundle mainBundle]];
			photoDetailViewController.imageFilename = [NSString stringWithFormat:@"%@", [photoMetadata objectForKey:@"filename"]];
			photoDetailViewController.title = [NSString stringWithFormat:@"%@", [photoMetadata objectForKey:@"phototitle"]];
			[self.navigationController pushViewController:photoDetailViewController animated:YES];
			[photoDetailViewController release];
		}
		i++;
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[photoArray release];
	
    [super dealloc];
}


@end
