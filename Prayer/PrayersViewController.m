//
//  PrayersViewController.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersViewController.h"

#import "PrayerCoreData.h"

@implementation PrayersViewController

@synthesize prayersTableView = _prayersTableView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Prayers";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPrayer:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self.prayersTableView setPrayers:[[PrayerCoreData sharedPrayerData] allPrayers]];
}

#pragma mark -
#pragma mark AppLogic

- (IBAction)addPrayer:(id)sender
{
    [[PrayerCoreData sharedPrayerData] newPrayer];
  //  [self.prayersTableView setPrayers:[[PrayerCoreData sharedPrayerData] allPrayers]];
}

@end
