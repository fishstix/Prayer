//
//  CategoriesViewController.m
//  Prayer
//
//  Created by Charles Fisher on 7/10/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "CategoriesViewController.h"

#import "PrayerCategory.h"

@interface CategoriesViewController () <UIAlertViewDelegate>
@end

@implementation CategoriesViewController

@synthesize categoriesTableView = _categoriesTableView;

#pragma mark -
#pragma mark Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCategory)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = dismissButton;
    
    self.title = @"Categories";
    
    [self.categoriesTableView setEditing:YES];
    
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self.categoriesTableView selector:@selector(reloadData) name:kDidAddPrayerCategory object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.categoriesTableView selector:@selector(reloadData) name:kDidRemovePrayerCategory object:nil];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self.categoriesTableView];
}

#pragma mark -
#pragma mark Category Management

- (void) addCategory
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Add Category"
                                                      message:nil
                                                     delegate:self 
                                            cancelButtonTitle:@"Cancel" 
                                            otherButtonTitles:@"OK", nil];
    
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [message show];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if( [inputText length] >= 1 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        NSString *newCategory = [[alertView textFieldAtIndex:0] text];
        [PrayerCategory addCategory:newCategory];
    }
}

#pragma mark -
#pragma mark Table Stuff

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [PrayerCategory getCategories].count;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *category = (NSString*)[[PrayerCategory getCategories] objectAtIndex:indexPath.row];
        [PrayerCategory removeCategory:category];
    }
}

#define kCategoryCellKey @"CategoryKey"

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCategoryCellKey];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCategoryCellKey];
        [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    }
    
    NSString *category = [[PrayerCategory getCategories] objectAtIndex:indexPath.row];
    cell.textLabel.text = category;
    
    return cell;
}

@end
