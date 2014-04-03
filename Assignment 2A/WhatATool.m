#import <Foundation/Foundation.h>
#import "PolygonShape.h"

void PrintPathInfo() { 
	NSString *pathString = @"~";
	pathString = [pathString stringByExpandingTildeInPath];
	NSLog(@"My home folder is at '%@'", pathString);
	NSLog(@"\n");
	
	NSArray *pathArray = [pathString pathComponents];
	for (NSString *tempString in pathArray) {
		NSLog(@"%@", tempString);
	}
	NSLog(@"\n");
}

void PrintProcessInfo() {
	NSString *processName = [[NSProcessInfo processInfo] processName];
	int processIdentifier = [[NSProcessInfo processInfo] processIdentifier];
	NSLog(@"Process Name: '%@' Process ID: '%d'", processName, processIdentifier);
	NSLog(@"\n");
}

void PrintBookmarkInfo() {
	NSMutableDictionary *urls = [NSMutableDictionary dictionary];
	NSURL *tempURL;
	tempURL = [NSURL URLWithString:@"http://www.stanford.edu"];
	[urls setObject:tempURL forKey:@"Stanford University"];
	tempURL = [NSURL URLWithString:@"http://www.apple.com"];
	[urls setObject:tempURL forKey:@"Apple"];
	tempURL = [NSURL URLWithString:@"http://cs193p.stanford.edu"];
	[urls setObject:tempURL forKey:@"CS193P"];
	tempURL = [NSURL URLWithString:@"http://itunes.stanford.edu"];
	[urls setObject:tempURL forKey:@"Stanford on iTunes U"];
	tempURL = [NSURL URLWithString:@"http://stanfordshop.com"];
	[urls setObject:tempURL forKey:@"Stanford Mall"];
	for (NSString *keyString in urls) {
		if([keyString hasPrefix:@"Stanford"])
			NSLog(@"Key: '%@' URL: '%@'", keyString, [urls objectForKey:keyString]);
	}
	NSLog(@"\n");
}

void PrintIntrospectionInfo() {
	NSMutableArray *array = [NSMutableArray array];
	SEL sel = @selector(lowercaseString);
	[array addObject:@" Hello World!"];
	[array addObject:[NSURL URLWithString:@"http://www.stanford.edu"]];
	[array addObject:[NSProcessInfo processInfo]];
	[array addObject:[NSMutableDictionary dictionary]];
	NSMutableString *mutableString = [NSMutableString stringWithCapacity:8];
	[mutableString setString:@"The Quick Brown Fox Jumped Over The Lazy Dog"];
	[array addObject:mutableString];
	for (id object in array) {
		NSLog(@"Class name:  %@", [object className]);
		if ([object isMemberOfClass:[NSString class]])
			NSLog(@"Is Member of NSString: YES");
		else
			NSLog(@"Is Member of NSString: NO");
		if ([object isKindOfClass:[NSString class]])
			NSLog(@"Is Kind of NSString: YES");
		else
			NSLog(@"Is Kind of NSString: NO");
		if ([object respondsToSelector:sel]) {
			NSLog(@"Responds to lowercaseString: YES");
			NSLog(@"lowercaseString is: %@", [object performSelector:sel]);
		}
		else
			NSLog(@"Responds to lowercaseString: NO");
		NSLog(@"======================================");
	}
}

void PrintPolygonInfo() {
	NSMutableArray *array = [[NSMutableArray alloc] init];
	PolygonShape *shape1 = [[PolygonShape alloc] initWithNumberOfSides:4 minimumNumberOfSides:3 maximumNumberOfSides:7];
	[array addObject:shape1];
	[shape1 description];
	PolygonShape *shape2 = [[PolygonShape alloc] initWithNumberOfSides:6 minimumNumberOfSides:5 maximumNumberOfSides:9];
	[array addObject:shape2];
	[shape2 description];
	PolygonShape *shape3 = [[PolygonShape alloc] initWithNumberOfSides:12 minimumNumberOfSides:9 maximumNumberOfSides:12];
	[array addObject:shape3];
	[shape3 description];
	
	for (PolygonShape *shape in array)
		[shape setNumberOfSides:10];
	
	[array removeObject:shape3];
	[shape3 release];
	[array removeObject:shape2];
	[shape2 release];
	[array removeObject:shape1];
	[shape1 release];
	[array release];
}

int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	// insert code here...
//	PrintPathInfo();			// Section 1
//	PrintProcessInfo();			// Section 2
//	PrintBookmarkInfo();		// Section 3
//	PrintIntrospectionInfo();	// Section 4
	PrintPolygonInfo();			// Section 6 (No function for section 5)
	
	[pool drain];
	return 0;
}
