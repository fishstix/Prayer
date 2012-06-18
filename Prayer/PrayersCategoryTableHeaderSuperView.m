//
//  PrayersCategoryTableHeaderSuperView.m
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersCategoryTableHeaderSuperView.h"

@implementation PrayersCategoryTableHeaderSuperView

@synthesize label = _label;

- (id) initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PrayersCategoryTableHeaderSuperView" owner:self options:nil];
    UIView *view = (UIView*) [nibViews objectAtIndex:0];
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, view.frame.size.width, view.frame.size.height)];
    
    if (self) {
        [self addSubview:[nibViews objectAtIndex:0]];
    }
    
    return self;
}

#pragma mark -
#pragma mark UI

- (void) updateUI:(BOOL)visible
{
    if (visible) {
        [self.label setText:@"Release to PRAY"];
    } else {
        [self.label setText:@"Pull down to PRAY"];
    }
}

@end
