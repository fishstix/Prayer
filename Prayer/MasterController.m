//
//  MasterController.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterController.h"

#import "PrayersViewController.h"
#import "PrayerViewController.h"

#import "MenuViewController.h"
#import "QuoteViewController.h"
#import "ShareViewController.h"
#import "CategoriesViewController.h"

static MasterController *sharedInstance = NULL;

@interface MasterController()
@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) UINavigationController *rootNavigationController;
@property (nonatomic, retain) MKDSlideViewController *slideController;
@end

@implementation MasterController

@synthesize rootViewController = _rootViewController;
//@synthesize rootNavigationController = _rootNavigationController;
@synthesize slideController = _slideController;
@dynamic rootNavigationController;

- (UINavigationController*) rootNavigationController
{
    return (UINavigationController*) self.slideController.mainViewController;
}

- (id) initWithAppWindow:(UIWindow *)window
{
    sharedInstance = [super init];
    
    if (sharedInstance) {
        PrayersViewController *rootViewController = [[PrayersViewController alloc] initWithNibName:@"PrayersViewController" bundle:nil];
        self.rootViewController = rootViewController;
        
        self.slideController = [[MKDSlideViewController alloc] initWithRootViewController:self.rootViewController];

        // Left
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        // Right
        QuoteViewController *quoteViewController = [[QuoteViewController alloc] initWithNibName:@"QuoteViewController" bundle:nil];
        
        [self.slideController setLeftViewController:menuViewController rightViewController:quoteViewController];
        
        [window setRootViewController:self.slideController];
    }
    
    return sharedInstance;
}

+ (id) sharedMasterController 
{
    return sharedInstance;
}

#pragma mark -
#pragma mark Navigation

- (void) pushController:(UIViewController *)controller
{
    [self.rootNavigationController pushViewController:controller animated:YES];
}

- (void) presentPrayer:(Prayer *)prayer
{
    PrayerViewController *prayerController = [[PrayerViewController alloc] initWithNibName:@"PrayerViewController" bundle:nil];
    prayerController.prayer = prayer;

    [self.rootNavigationController setViewControllers:[NSArray arrayWithObjects:self.rootViewController, prayerController, nil] animated:YES];
}

- (void) sharePrayer:(Prayer *)prayer
{
    ShareViewController *shareController = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    shareController.prayer = prayer;
    
    [self.rootNavigationController pushViewController:shareController animated:YES];
}

- (void) presentCategories
{
    CategoriesViewController *categoriesController = [[CategoriesViewController alloc] initWithNibName:@"CategoriesViewController" bundle:nil];
    UINavigationController *navCategoriesController = [[UINavigationController alloc] initWithRootViewController:categoriesController];
    
    [self.slideController presentModalViewController:navCategoriesController animated:YES];
}

@end
