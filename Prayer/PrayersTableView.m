//
//  PrayersTableView.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "PrayersTableView.h"

#import "PrayersCategoryTableHeaderView.h"
#import "PrayersCategoryTableHeaderSuperView.h"

#import "MasterController.h"
#import "Prayer.h"
#import "PrayerCoreData.h"
#import "PrayerViewController.h"

@interface PrayersTableView()
- (void) didUpdatePrayers:(NSNotification*)notification;
@end

@implementation PrayersTableView

@synthesize prayersTableView = _prayersTableView;
@synthesize headerView = _headerView;
@synthesize category = _category;
@synthesize prayers = _prayers;
@synthesize editing = _editing;

- (void) setEditing:(BOOL)editing
{
    _editing = editing;
    
    [self.prayersTableView setEditing:editing animated:YES];
    [self.headerView setEditing:editing];
}

- (void) awakeFromNib 
{
    [super awakeFromNib];
    
    [self.prayersTableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
     
    [self addObserver:self forKeyPath:@"prayers" options:NSKeyValueChangeReplacement context:NULL];
}

- (id) initWithFrame:(CGRect)frame PrayerCategory:(NSString *)category
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PrayersTableView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];

        // Data
        self.category = category;
        self.prayers = [[PrayerCoreData sharedPrayerData] allPrayersForCategory:category];
        
        // Header
        self.headerView = [[PrayersCategoryTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.prayersTableView.frame.size.width, 100) Category:category];
        [self.headerView setEditing:self.editing];
        [self.prayersTableView setTableHeaderView:self.headerView];
        // Super
        UIView *superView = [[PrayersCategoryTableHeaderSuperView alloc] initWithFrame:CGRectMake(0, 0, self.prayersTableView.frame.size.width, 50)];
        [self.prayersTableView setTableHeaderSuperView:superView];
        
        // Footer
        [self.prayersTableView setTableFooterView:[[UIView alloc] init]];
        
        // Observe
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdatePrayers:) name:kDidAddPrayer object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdatePrayers:) name:kDidRemovePrayer object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdatePrayers:) name:kDidUpdatePrayer object:nil];
    }
    
    return self;
}
         
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.prayersTableView reloadData];
}

#pragma mark -
#pragma mark Data

- (void) didUpdatePrayers:(NSNotification *)notification
{
    self.prayers = [[PrayerCoreData sharedPrayerData] allPrayersForCategory:self.category];
    [self.prayersTableView reloadData];
}

#pragma mark -
#pragma mark TableView Datasource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.prayers count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:CellIdentifier];
    }
    
    Prayer *prayer = [self.prayers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = prayer.title;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selected = NO;
    
    return cell;
}

#pragma mark -
#pragma mark TableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrayerViewController *prayerController = [[PrayerViewController alloc] initWithNibName:@"PrayerViewController" bundle:nil];

    Prayer *prayer = [self.prayers objectAtIndex:indexPath.row];
    [prayerController setPrayer:prayer];
    
    [[MasterController sharedMasterController] pushController:prayerController];
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Prayer *prayer = [self.prayers objectAtIndex:indexPath.row];
        [[PrayerCoreData sharedPrayerData] deletePrayer:prayer];
    }
}

#pragma mark -
#pragma mark Dealloc

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
