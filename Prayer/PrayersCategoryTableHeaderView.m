//
//  PrayersCategoryTableHeaderView.m
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersCategoryTableHeaderView.h"

#import "PrayerCoreData.h"
#import "Prayer.h"

@implementation PrayersCategoryTableHeaderView

@synthesize categoryLabel = _categoryLabel;

@dynamic category;

- (NSString*) category
{
    return self.categoryLabel.text;
}

- (void) setCategory:(NSString *)category
{
    self.categoryLabel.text = category;
}

- (id) initWithFrame:(CGRect)frame Category:(NSString *)category
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PrayersCategoryTableHeaderView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];
        
        self.category = category;
    }
    
    return self;
}

#pragma mark -
#pragma mark Prayer

- (IBAction)addPrayer:(id)sender
{
    [[PrayerCoreData sharedPrayerData] newPrayerForCategory:self.category];
}

@end
