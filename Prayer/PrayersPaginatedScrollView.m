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

@synthesize scrollView = _scrollView;
@synthesize tableViews = _tableViews;
@synthesize currentPage = _currentPage;
@synthesize editing = _editing;

- (void) setEditing:(BOOL)editing
{
    _editing = editing;
    
    // Refresh UI
    for (UIView *prayerView in self.tableViews) {
        if ([prayerView isKindOfClass:[PrayersTableView class]]) {
            [((PrayersTableView*) prayerView) setEditing:editing];
        }
    }
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        self.tableViews = [NSMutableArray arrayWithObjects:[NSNull null],[NSNull null],nil];    
        for (NSString *prayerCategory in [PrayerCategory getCategories]) {
            [self.tableViews addObject:[NSNull null]];
        }
        
        [self initialize];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.scrollView];
        
        self.tableViews = [NSMutableArray arrayWithObjects:[NSNull null],[NSNull null],nil];    
        for (NSString *prayerCategory in [PrayerCategory getCategories]) {
            [self.tableViews addObject:[NSNull null]];
        }
        
        self.currentPage = 0;
        [self initialize];
    }
    return self;
}

- (void) initialize 
{
    [self updateScrollView];
    
    NSLog(@"Starting index: %d", self.currentPage);
    NSLog(@"Scroll Content Height: %f", self.scrollView.contentSize.height);
    [self loadScrollViewWithPage:self.currentPage - 1];
    [self loadScrollViewWithPage:self.currentPage];
    [self loadScrollViewWithPage:self.currentPage + 1];
    
    // Listen
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddPrayerCategory:) name:kDidAddPrayerCategory object:nil];
}

#pragma mark - 
#pragma mark Manage Views

- (void) updateScrollView {
    int width = self.scrollView.frame.size.width;
    
    self.scrollView.contentSize = CGSizeMake(width * [self.tableViews count], self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:CGRectMake(self.currentPage * width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
}


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= [self.tableViews count]) return;
    
    
	UIView *testView = [self.tableViews objectAtIndex:page];
    if ((NSNull *)testView == [NSNull null]) {
        testView = [self viewForPage:page];

        [self.tableViews replaceObjectAtIndex:page withObject:testView];
    }
    
    if (testView.superview == nil) {
        // add the controller's view to the scroll view
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        frame.size.height = self.scrollView.contentSize.height;
        
        testView.frame = frame;
        NSLog(@"Test Frame width: %f height: %f", frame.size.width, frame.size.height);
        NSLog(@"Adding Frame width: %f height: %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        [self.scrollView addSubview:testView];
    }
}

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

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    if (page < 0 || page >= [self.tableViews count]) {
        return;
    }  
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// TODO call view did appear and disappear methods
    if (page > 0) {
        AppView *appView = [self.tableViews objectAtIndex:page - 1];
        [appView viewDidDisappear];
    }
    if (page < [self.tableViews count] - 1) {
        AppView *appView = [self.tableViews objectAtIndex:page + 1];
        [appView viewDidDisappear];
    }
    
    AppView *appView = [self.tableViews objectAtIndex:page];
    [appView viewDidAppear];
    
    self.currentPage = page;
}

#pragma mark -
#pragma mark Prayer Category 

- (void) didAddPrayerCategory:(NSNotification*) notification
{

    UIView *currentView = [self.tableViews objectAtIndex:(self.currentPage)];
    UIView *newTableView = [self viewForPage:self.currentPage];

    newTableView.alpha = 0.0f;
    [newTableView setFrame:CGRectMake(currentView.frame.origin.x + 20, currentView.frame.origin.y + 20, newTableView.frame.size.width - 40, newTableView.frame.size.height - 40)];
    [self.scrollView insertSubview:newTableView atIndex:0];
    
    [self.tableViews insertObject:newTableView atIndex:self.currentPage];
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
    
//    [self loadScrollViewWithPage:self.currentPage];
//    [self loadScrollViewWithPage:self.currentPage + 1];
}

- (void) didRemovePrayerCategory:(NSNotification *)notification
{
    
}

@end
