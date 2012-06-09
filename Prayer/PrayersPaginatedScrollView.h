//
//  PrayersPaginatedScrollView.h
//  Prayer
//
//  Created by Charles Fisher on 4/10/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSPaginatedScrollView.h"

@interface PrayersPaginatedScrollView : FSPaginatedScrollView {
    BOOL _editing;
}

@property (nonatomic, assign) BOOL editing;

@end
