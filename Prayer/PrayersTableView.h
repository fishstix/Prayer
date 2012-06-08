//
//  PrayersTableView.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppView.h"

#import "PrayersCategoryTableHeaderView.h"

@interface PrayersTableView : AppView <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_prayersTableView;
    PrayersCategoryTableHeaderView *_headerView;
    
    NSString *_category;
    NSArray *_prayers;
    
    BOOL _editing;
}

@property (nonatomic, retain) IBOutlet UITableView *prayersTableView;
@property (nonatomic, retain) PrayersCategoryTableHeaderView *headerView;

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSArray *prayers;

@property (nonatomic, assign) BOOL editing;

- (id) initWithFrame:(CGRect)frame PrayerCategory:(NSString*)category;

@end
