//
//  PrayerNotificationManager.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrayerNotificationManager : NSObject

+ (id) sharedManager;
- (void) updateNotifications;

@end
