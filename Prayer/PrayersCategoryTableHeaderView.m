//
//  PrayersCategoryTableHeaderView.m
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersCategoryTableHeaderView.h"

#import <QuartzCore/QuartzCore.h>

#import "PrayerCoreData.h"
#import "Prayer.h"
#import "PrayerCategory.h"

@interface PrayersCategoryTableHeaderView()
- (void) refreshUI;
@end

@implementation PrayersCategoryTableHeaderView

@synthesize editing = _editing;
@synthesize deleting = _deleting;
@synthesize categoryLabel = _categoryLabel;
@synthesize addPrayerButton = _addPrayerButton;
@synthesize deleteCategoryButton = _deleteCategoryButton;
@synthesize toggleDeleteCategoryButton = _toggleDeleteCategoryButton;

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
    self.deleting = NO;
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

- (IBAction)toggleDeleteCategory:(id)sender
{
    self.deleting = !self.deleting;
    [self refreshUI];
}

#pragma mark -
#pragma mark UI

#define animation_duration 0.3f
#define move_over 30

- (void) refreshUI 
{
    BOOL add = (!self.category || [self.category isEqualToString:@""]) || self.editing;
    BOOL delete = (!self.category || [self.category isEqualToString:@""]) || !self.editing || !self.deleting;
    BOOL toggle =  (!self.category || [self.category isEqualToString:@""]) || !self.editing;
    
    // ADD
    if (add && self.addPrayerButton.alpha == 1.0f) {
        // Hide
        [UIView animateWithDuration:animation_duration
                         animations:^{
                             self.addPrayerButton.alpha = 0.0f;
                         }];
    } else if (!add && self.addPrayerButton.alpha == 0.0f) {
        // Show
        [UIView animateWithDuration:animation_duration
                         animations:^{
                             self.addPrayerButton.alpha = 1.0f;
                         }];
    }
    
    
    // DELETE
    if (delete && self.deleteCategoryButton.alpha == 1.0f) {
        // HIDE & ROTATE TOGGLE
        [UIView animateWithDuration:animation_duration
                         animations:^{
                             self.toggleDeleteCategoryButton.transform = CGAffineTransformMakeRotation(0);
                             self.deleteCategoryButton.alpha = 0.0f;
                         }];
    } else if (!delete && self.deleteCategoryButton.alpha == 0.0f) {
        // SHOW & ROTATE TOGGLE
        [UIView animateWithDuration:animation_duration
                         animations:^{
                             self.toggleDeleteCategoryButton.transform = CGAffineTransformMakeRotation(-M_PI_2);
                             self.deleteCategoryButton.alpha = 1.0f;
                         }];
    }
    
    // TOGGLE
    if (toggle && self.toggleDeleteCategoryButton.alpha == 1.0f) {
        // Hide
        [UIView animateWithDuration:animation_duration
                         animations:^{
                             self.toggleDeleteCategoryButton.center = CGPointMake(self.toggleDeleteCategoryButton.center.x - move_over, self.toggleDeleteCategoryButton.center.y);
                             self.toggleDeleteCategoryButton.alpha = 0.0f;
                             
                             self.categoryLabel.center = CGPointMake(self.categoryLabel.center.x - move_over, self.categoryLabel.center.y);
                         }];
    } else if (!toggle && self.toggleDeleteCategoryButton.alpha == 0.0f) {
        // Show
        [UIView animateWithDuration:animation_duration
                         animations:^{
                             self.toggleDeleteCategoryButton.center = CGPointMake(self.toggleDeleteCategoryButton.center.x + move_over, self.toggleDeleteCategoryButton.center.y);
                             self.toggleDeleteCategoryButton.alpha = 1.0f;
                             self.toggleDeleteCategoryButton.transform = CGAffineTransformMakeRotation(0);
                             
                             self.categoryLabel.center = CGPointMake(self.categoryLabel.center.x + move_over, self.categoryLabel.center.y);
                         }];

    }
}

#pragma mark -
#pragma mark Dealloc

- (void) dealloc
{
    [self removeObserver:self forKeyPath:@"editing"];
}

@end
