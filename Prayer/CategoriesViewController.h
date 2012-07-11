//
//  CategoriesViewController.h
//  Prayer
//
//  Created by Charles Fisher on 7/10/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "AppViewController.h"

#import "FSTableView.h"

@interface CategoriesViewController : AppViewController <FSTableViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    FSTableView *_categoriesTableView;
}

@property (nonatomic, strong) IBOutlet FSTableView *categoriesTableView;

@end
