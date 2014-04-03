//
//  Person.h
//  Paparazzi3
//
//  Created by Eugene Moon on 9/16/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Photo;

@interface Person :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSSet* photoSet;

@end


@interface Person (CoreDataGeneratedAccessors)
- (void)addPhotoSetObject:(Photo *)value;
- (void)removePhotoSetObject:(Photo *)value;
- (void)addPhotoSet:(NSSet *)value;
- (void)removePhotoSet:(NSSet *)value;

@end

