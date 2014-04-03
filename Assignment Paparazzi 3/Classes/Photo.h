//
//  Photo.h
//  Paparazzi3
//
//  Created by Eugene Moon on 9/16/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;

@interface Photo :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * secret;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * farm;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSData * photodatasquare;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * server;
@property (nonatomic, retain) NSString * photoid;
@property (nonatomic, retain) NSData * photodatalarge;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) Person * person;

@end



