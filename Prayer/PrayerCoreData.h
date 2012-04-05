//
//  PrayerCoreData.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Prayer.h"

@interface PrayerCoreData : NSObject

+ (id) sharedPrayerData;

- (Prayer*) newPrayer;
- (Prayer*) prayerFromURI:(NSString*)URI;
- (NSArray*) allPrayers;
- (void) save;

@end
