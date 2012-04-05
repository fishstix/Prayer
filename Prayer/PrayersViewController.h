//
//  PrayersViewController.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppViewController.h"

#import "PrayersTableView.h"

@interface PrayersViewController : AppViewController {
    PrayersTableView *_prayersTableView;

//    NSArray *_prayers;
}

@property (nonatomic, retain) IBOutlet PrayersTableView *prayersTableView;

//@property (nonatomic, retain) NSArray *prayers;

- (IBAction)addPrayer:(id)sender;

@end
