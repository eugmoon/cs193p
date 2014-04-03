//
//  Photo.h
//  foo2
//
//  Created by Eugene Moon on 7/9/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;

@interface Photo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) Person * person;

@end



