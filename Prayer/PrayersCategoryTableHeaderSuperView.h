//
//  PrayersCategoryTableHeaderSuperView.h
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSTableHeaderSuperView.h"

@interface PrayersCategoryTableHeaderSuperView : FSTableHeaderSuperView
{
    UILabel *_label;
}

@property (nonatomic, retain) IBOutlet UILabel *label;

@end
