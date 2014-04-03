//
//  UserDetailViewController.h
//  foo
//
//  Created by Eugene Moon on 7/29/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserDetailViewControllerDelegate;

@interface UserDetailViewController : UIViewController {
	IBOutlet UITextField *textField;
	id<UserDetailViewControllerDelegate> delegate;
}

@property (retain) UITextField *textField;
@property (assign) id<UserDetailViewControllerDelegate> delegate;

- (IBAction)doneButtonPressed:(id)sender;

@end

@protocol UserDetailViewControllerDelegate <NSObject>

- (void)didSetFlickrUsername:(NSString *)username;

@end