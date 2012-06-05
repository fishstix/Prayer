//
//  PrayerCoreData.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Prayer.h"

extern NSString *const kDidAddPrayer;
extern NSString *const kDidRemovePrayer;

@interface PrayerCoreData : NSObject

+ (id) sharedPrayerData;

- (Prayer*) newPrayer;
- (Prayer*) newPrayerForCategory:(NSString*)category;
- (Prayer*) prayerFromURI:(NSString*)URI;
- (NSArray*) allPrayers;
- (NSArray*) allPrayersForCategory:(NSString*)category;
- (void) save;

@end
