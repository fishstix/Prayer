//
//  PrayersTableView.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppView.h"

@interface PrayersTableView : AppView <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_prayersTableView;
    
    NSArray *_prayers;
}

@property (nonatomic, retain) IBOutlet UITableView *prayersTableView;

@property (nonatomic, retain) NSArray *prayers;

//- (id) initWithFrame:(CGRect)frame Prayers:(NSArray*)prayers;
// Add Prayer

@end
