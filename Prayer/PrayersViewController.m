//
//  PrayersViewController.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayersViewController.h"

#import "PrayerCoreData.h"

@interface PrayersViewController()
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@end

@implementation PrayersViewController

@synthesize prayersScrollView = _prayersScrollView;

@synthesize editButton = _editButton;
@synthesize doneButton = _doneButton;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Prayers";
    
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editMode:)];
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editMode:)];
    self.navigationItem.rightBarButtonItem = self.editButton;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark AppLogic

- (IBAction)editMode:(id)sender
{
    // Edit Mode?
    if (self.navigationItem.rightBarButtonItem == self.doneButton) {
        // Toggle Off
        self.navigationItem.rightBarButtonItem = self.editButton;
        self.prayersScrollView.editing = NO;
    } else {
        // Toggle On
        self.navigationItem.rightBarButtonItem = self.doneButton;
        self.prayersScrollView.editing = YES;
    }
}

@end
