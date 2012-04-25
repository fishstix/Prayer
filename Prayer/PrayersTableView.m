//
//  PrayersTableView.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersTableView.h"

#import "MasterController.h"
#import "Prayer.h"
#import "PrayerCoreData.h"
#import "PrayerViewController.h"

@implementation PrayersTableView

@synthesize prayersTableView = _prayersTableView;
@synthesize prayers = _prayers;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PrayersTableView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];
        
        // Data
        self.prayers = [NSArray array];
        // Listen
//        [self.prayers addObserver:self forKeyPath:@" options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>
//        [self addObserver:self forKeyPath:@"prayers" options:NSKeyValueChangeReplacement context:NULL];
    }
    
    return self;
}

- (void) awakeFromNib 
{
    [super awakeFromNib];
    
    [self.prayersTableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
     
    [self addObserver:self forKeyPath:@"prayers" options:NSKeyValueChangeReplacement context:NULL];
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PrayersTableView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];
        
        [self setPrayers:[[PrayerCoreData sharedPrayerData] allPrayers]];
//        self.prayers = [NSArray array];
    }
    
    return self;
}
         
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
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

@end
