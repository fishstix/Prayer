//
//  PrayerCategory.h
//  Prayer
//
//  Created by Charles Fisher on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrayerCategory : NSObject

+ (void) addCategory:(NSString*)prayerCategory;
+ (void) removeCategory:(NSString*)prayerCategory;
+ (NSArray*) getCategories;

@end
