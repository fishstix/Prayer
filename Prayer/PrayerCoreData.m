//
//  PrayerCoreData.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayerCoreData.h"

#import "AppDelegate.h"
#import "PrayerNotificationManager.h"

static PrayerCoreData *sharedInstance = NULL;

@interface PrayerCoreData()
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation PrayerCoreData

@dynamic persistentStoreCoordinator;
@dynamic managedObjectContext;

- (NSPersistentStoreCoordinator*) persistentStoreCoordinator
{
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] persistentStoreCoordinator];
}

- (NSManagedObjectContext*) managedObjectContext
{
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark -
#pragma mark Singleton

+ (id) sharedPrayerData
{
    @synchronized(self)
    {
        if (sharedInstance == NULL) {
            sharedInstance = [[PrayerCoreData alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark -
#pragma mark Access

- (Prayer*) newPrayer
{
    Prayer *newPrayer = [NSEntityDescription insertNewObjectForEntityForName:@"Prayer" inManagedObjectContext:self.managedObjectContext];
    
    int numberPrayers = [[self allPrayers] count];
    [newPrayer setTitle:[NSString stringWithFormat:@"Prayer Number: %d", numberPrayers]];
    [newPrayer setBody:@""];
    [newPrayer setCreated_at:[NSDate date]];
    [newPrayer setAnswered:NO];
    
    [self save];
    return newPrayer;
}

- (Prayer*) prayerFromURI:(NSString *)URI
{
    NSURL *url = [[NSURL alloc] initWithString:URI];
    NSManagedObjectID *objectID = [self.persistentStoreCoordinator managedObjectIDForURIRepresentation:url];
    
    NSError *error = nil;
    Prayer *prayer = (Prayer*) [self.managedObjectContext existingObjectWithID:objectID error:&error];
    
    return prayer;
}

- (NSArray*) allPrayers
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Prayer" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    // TODO none needed?    
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
//                                        initWithKey:@"firstName" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (error) {
        // BLAH
        return [NSArray array];
    }
    return array;
}

- (void) save
{
    [self.managedObjectContext save:nil];
    
    [[PrayerNotificationManager sharedManager] updateNotifications];
}

@end
