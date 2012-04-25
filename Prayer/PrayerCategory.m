//
//  PrayerCategory.m
//  Prayer
//
//  Created by Charles Fisher on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayerCategory.h"

#define kPrayerArrayKey @"prayer_categories"

@implementation PrayerCategory

+ (void) addCategory:(NSString *)prayerCategory
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *prayerCategories = (NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)[defaults objectForKey:kPrayerArrayKey]];
    if (!prayerCategories) {
        prayerCategories = [NSArray array];
    }
    prayerCategories = [prayerCategories arrayByAddingObject:prayerCategory];
    NSData *prayerData = [NSKeyedArchiver archivedDataWithRootObject:prayerCategories];
    [defaults setObject:prayerData forKey:kPrayerArrayKey];
}

+ (void) removeCategory:(NSString *)prayerCategory
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *prayerCategories = [NSMutableArray arrayWithArray:(NSArray*) (NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)[defaults objectForKey:kPrayerArrayKey]]];
    [prayerCategories removeObject:prayerCategory];
    NSData *prayerData = [NSKeyedArchiver archivedDataWithRootObject:prayerCategories];
    [defaults setObject:prayerData forKey:kPrayerArrayKey];
}

+ (NSArray*) getCategories
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *prayerCategories = (NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)[defaults objectForKey:kPrayerArrayKey]];
    return prayerCategories ? prayerCategories : [NSArray array];
}

@end
