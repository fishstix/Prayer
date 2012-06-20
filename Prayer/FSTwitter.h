//
//  FSTwitter.h
//  Prayer
//
//  Created by Charles Fisher on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PrayerTwitterSharingDidChange @"Notification_PrayerTwitterSharingDidChange"

@interface FSTwitter : NSObject

@property (nonatomic, assign) BOOL sharing;

+ (FSTwitter*) sharedTwitterManager;
- (void) tweet:(NSString*)tweety;

@end
