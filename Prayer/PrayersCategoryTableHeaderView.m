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
#import "PrayerCategory.h"

@interface PrayersCategoryTableHeaderView()
- (void) refreshUI;
@end

@implementation PrayersCategoryTableHeaderView

@synthesize editing = _editing;
@synthesize categoryLabel = _categoryLabel;
@synthesize addPrayerButton = _addPrayerButton;
@synthesize deleteCategoryButton = _deleteCategoryButton;

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
        
        [self refreshUI];
        [self addObserver:self forKeyPath:@"editing" options:NSKeyValueChangeReplacement context:NULL];
    }
    
    return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self refreshUI];
}

#pragma mark -
#pragma mark Prayer

- (IBAction)addPrayer:(id)sender
{
    [[PrayerCoreData sharedPrayerData] newPrayerForCategory:self.category];
}

-(IBAction)deleteCategory:(id)sender 
{
    [PrayerCategory removeCategory:self.category];
}

#pragma mark -
#pragma mark UI

- (void) refreshUI 
{
    self.addPrayerButton.hidden = (!self.category || [self.category isEqualToString:@""]) || self.editing;
    self.deleteCategoryButton.hidden = (!self.category || [self.category isEqualToString:@""]) || !self.editing;
}

#pragma mark -
#pragma mark Dealloc

- (void) dealloc
{
    [self removeObserver:self forKeyPath:@"editing"];
}

@end
