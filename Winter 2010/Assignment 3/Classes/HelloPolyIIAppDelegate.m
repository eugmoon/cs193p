//
//  HelloPolyIIAppDelegate.m
//  HelloPolyII
//
//  Created by Eugene Moon on 6/7/12.
//  Copyright EMG 2012. All rights reserved.
//

#import "HelloPolyIIAppDelegate.h"

@implementation HelloPolyIIAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	[standardUserDefaults setInteger:defaultPolygon.numberOfSides forKey:@"numberOfSides"];
}

- (void)dealloc {
	[defaultPolygon release];
	
	[window release];
	[super dealloc];
}


@end
