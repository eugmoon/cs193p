//
//  Person.h
//  foo2
//
//  Created by Eugene Moon on 7/9/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Photo;

@interface Person :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* photoSet;

@end


@interface Person (CoreDataGeneratedAccessors)
- (void)addPhotoSetObject:(Photo *)value;
- (void)removePhotoSetObject:(Photo *)value;
- (void)addPhotoSet:(NSSet *)value;
- (void)removePhotoSet:(NSSet *)value;

@end

