//
//  PrayersViewController.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "AppViewController.h"

#import "PrayersPaginatedScrollView.h"

@interface PrayersViewController : AppViewController {
    PrayersPaginatedScrollView *_prayersScrollView;

    UIBarButtonItem *_editButton;
    UIBarButtonItem *_doneButton;
}

@property (nonatomic, retain) IBOutlet PrayersPaginatedScrollView *prayersScrollView;

- (IBAction)addPrayer:(id)sender;
- (IBAction)editMode:(id)sender;

@end
