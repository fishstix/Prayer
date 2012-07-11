//
//  PrayersTableView.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "AppView.h"

#import "FSTableView.h"
#import "PrayersCategoryTableHeaderView.h"

@interface PrayersTableView : AppView <FSTableViewDelegate, UITableViewDataSource> {
    FSTableView *_prayersTableView;
    PrayersCategoryTableHeaderView *_headerView;
    
    NSString *_category;
    NSArray *_prayers;
    
    BOOL _editing;
}

@property (nonatomic, strong) IBOutlet FSTableView *prayersTableView;
@property (nonatomic, strong) PrayersCategoryTableHeaderView *headerView;

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *prayers;

@property (nonatomic, assign) BOOL editing;

- (id) initWithFrame:(CGRect)frame PrayerCategory:(NSString*)category;

@end
