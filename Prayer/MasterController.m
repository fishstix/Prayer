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

static MasterController *sharedInstance = NULL;

@interface MasterController()
@property (nonatomic, retain) UIViewController *rootViewController;
@property (nonatomic, retain) UINavigationController *rootNavigationController;
@end

@implementation MasterController

@synthesize rootViewController = _rootViewController;
@synthesize rootNavigationController = _rootNavigationController;

- (id) initWithAppWindow:(UIWindow *)window
{
    sharedInstance = [super init];
    
    if (sharedInstance) {
        PrayersViewController *rootViewController = [[PrayersViewController alloc] initWithNibName:@"PrayersViewController" bundle:nil];
        self.rootViewController = rootViewController;
        
        self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
        
        [window setRootViewController:self.rootNavigationController];
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

@end
