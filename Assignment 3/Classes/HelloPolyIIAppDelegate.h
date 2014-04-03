//
//  HelloPolyIIAppDelegate.h
//  HelloPolyII
//
//  Created by Eugene Moon on 6/2/12.
//  Copyright EMG 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"

@interface HelloPolyIIAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	IBOutlet PolygonShape *defaultPolygon;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

