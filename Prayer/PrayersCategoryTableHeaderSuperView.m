//
//  PrayersCategoryTableHeaderSuperView.m
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersCategoryTableHeaderSuperView.h"

@implementation PrayersCategoryTableHeaderSuperView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PrayersCategoryTableHeaderSuperView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];
    }
    
    return self;
}

@end
