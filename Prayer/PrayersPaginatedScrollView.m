//
//  PrayersPaginatedScrollView.m
//  Prayer
//
//  Created by Charles Fisher on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersPaginatedScrollView.h"

#import "PrayersTableView.h"
#import "AddPrayerCategoryView.h"

#import "PrayerCoreData.h"
#import "PrayerCategory.h"

@interface PrayersPaginatedScrollView() <UIScrollViewDelegate>
- (void) initialize;

- (void) updateScrollView;
- (void) loadScrollViewWithPage:(int)page;
- (UIView*) viewForPage:(int)page;

- (void) didAddPrayerCategory:(NSNotification*) notification;
- (void) didRemovePrayerCategory:(NSNotification*) notification;

@end

@implementation PrayersPaginatedScrollView

@synthesize editing = _editing;

- (void) setEditing:(BOOL)editing
{
    _editing = editing;
    
    // Refresh UI
    for (UIView *prayerView in self.appViews) {
        if ([prayerView isKindOfClass:[PrayersTableView class]]) {
            [((PrayersTableView*) prayerView) setEditing:editing];
        }
    }
}

- (void) initialize 
{
    self.appViews = [NSMutableArray arrayWithObjects:[NSNull null],[NSNull null],nil];    
    for (NSString *prayerCategory in [PrayerCategory getCategories]) {
        [self.appViews addObject:[NSNull null]];
    }
    
    // Start on page 1 if no prayers
    if ([[[PrayerCoreData sharedPrayerData] allPrayers] count] == 0) {
        self.currentPage = 1;
    }
    
    [super initialize];
    
    // Listen
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddPrayerCategory:) name:kDidAddPrayerCategory object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemovePrayerCategory:) name:kDidRemovePrayerCategory object:nil];
}

#pragma mark - 
#pragma mark Manage Views

- (UIView*) viewForPage:(int)page
{
    NSArray *prayerCategories = [PrayerCategory getCategories];
#warning if page == 0	
    
    if (page == 0) {
        PrayersTableView *allPrayersTableView = [[PrayersTableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) PrayerCategory:nil];
        [allPrayersTableView setEditing:self.editing];
        
        return allPrayersTableView;
    } else 
    if (page != 0 && page <= [prayerCategories count]) {
        NSString *category = [prayerCategories objectAtIndex:page - 1];
        NSLog(@"Category: %@", category);
        
        PrayersTableView *prayersTableView = [[PrayersTableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) PrayerCategory:category];
        [prayersTableView setEditing:self.editing];
        
        return prayersTableView;
    }
    
    // Add Category
    AddPrayerCategoryView *addCategoryView = [[AddPrayerCategoryView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    return addCategoryView;
}

#pragma mark -
#pragma mark Prayer Category 

- (void) didAddPrayerCategory:(NSNotification*) notification
{
    NSString *newCategory = (NSString*) notification.object;
    int page = [[PrayerCategory getCategories] indexOfObject:newCategory];
    
    UIView *currentView = [self.appViews objectAtIndex:(page + 1)];
    UIView *newTableView = [self viewForPage:page + 1];

    newTableView.alpha = 0.0f;
    [newTableView setFrame:CGRectMake(currentView.frame.origin.x + 20, currentView.frame.origin.y + 20, newTableView.frame.size.width - 40, newTableView.frame.size.height - 40)];
    [self.scrollView insertSubview:newTableView atIndex:0];
    
    [self.appViews insertObject:newTableView atIndex:page + 1];
//    [self updateScrollView];
    
    // Animate
    [UIView animateWithDuration:0.5 animations:^{
        // Grow
        newTableView.frame = CGRectMake(currentView.frame.origin.x, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
        // Appear
        newTableView.alpha = 1.0f;

        // Move
        currentView.frame = CGRectMake(currentView.frame.origin.x + self.scrollView.frame.size.width, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
        
    }
                     completion:^(BOOL finished) {
                         [self updateScrollView];
                     }];
}

- (void) didRemovePrayerCategory:(NSNotification *)notification
{
    NSString *removedCategory = (NSString*) notification.object;
    
    // Find page to be deleted
    int page = 0;
    for (int i = 0; i < self.appViews.count; i++) {
        UIView *view = (UIView*) [self.appViews objectAtIndex:i];
        if (![view isEqual:[NSNull null]] && [view isKindOfClass:[PrayersTableView class]]) {
            PrayersTableView *tableView = (PrayersTableView*)view;
            if ([tableView.category isEqualToString:removedCategory]) {
                page = i;
                break;
            }
        }
    }
    
    // Error handling?
    if (page == 0) {
        return;
    }
    
    UIView *currentView = [self.appViews objectAtIndex:page];
    // Remove
    [self.appViews removeObjectAtIndex:page];
    // The one coming in
    
//    newTableView.alpha = 1.0f;
//    [newTableView setFrame:CGRectMake(currentView.frame.origin.x + 20, currentView.frame.origin.y + 20, newTableView.frame.size.width - 40, newTableView.frame.size.height - 40)];
//    [self.scrollView insertSubview:newTableView atIndex:0];
    
//    [self.tableViews insertObject:newTableView atIndex:self.currentPage];
    
    // Animate
    [UIView animateWithDuration:0.5 animations:^{
        // Move Back
        for (int i = page; i < [self.appViews count]; i++) {
            UIView *tableView = [self.appViews objectAtIndex:i];
            if ([tableView isEqual:[NSNull null]]) {
                continue;
            }
            tableView.frame = CGRectMake(tableView.frame.origin.x - tableView.frame.size.width, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
        }
//        
//        newTableView.frame = CGRectMake(currentView.frame.origin.x, currentView.frame.origin.y, currentView.frame.size.width, currentView.frame.size.height);
        // Appear
//        newTableView.alpha = 1.0f;
        
        // Move
        currentView.alpha = 0.0f;
        currentView.frame = CGRectMake(currentView.frame.origin.x, currentView.frame.origin.y + 300, currentView.frame.size.width, currentView.frame.size.height);
        
    }
                     completion:^(BOOL finished) {
                         [self updateScrollView];
                         
                         [currentView removeFromSuperview];
                     }];
}

@end
