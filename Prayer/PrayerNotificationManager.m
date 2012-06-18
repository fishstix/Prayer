//
//  PrayerNotificationManager.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayerNotificationManager.h"

#import "PrayerCoreData.h"
#import "Prayer.h"

static PrayerNotificationManager *sharedInstance = NULL;

@implementation PrayerNotificationManager

#pragma mark -
#pragma mark Singleton

+ (id) sharedManager 
{
    @synchronized(self) 
    {
        if (sharedInstance == NULL) {
            sharedInstance = [[PrayerNotificationManager alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark -
#pragma mark App Logic

- (void) updateNotifications
{
    // Clear Existing Notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    for (Prayer *prayer in [[PrayerCoreData sharedPrayerData] allPrayers]) {
        // If date set
        if (prayer.remind_at && [prayer.remind_at compare:[NSDate date]] == NSOrderedDescending) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            
            notification.fireDate = prayer.remind_at;
            notification.repeatInterval = prayer.recure;
            notification.alertBody = prayer.title;
            notification.userInfo = [NSDictionary dictionaryWithObject:prayer.objectID.URIRepresentation.absoluteString forKey:@"objectID"];
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
}

@end
