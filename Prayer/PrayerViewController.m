//
//  PrayerViewController.m
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayerViewController.h"

#import "PrayerCoreData.h"

@implementation PrayerViewController

@synthesize titleTextField = _titleTextField;
@synthesize reminderDatePicker = _reminderDatePicker;

@synthesize prayer = _prayer;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleTextField.text = self.prayer.title;
    
#warning Go back to 30 minutes
//    self.reminderDatePicker.minuteInterval = 30;
    self.reminderDatePicker.date = self.prayer.remind_at ? self.prayer.remind_at : [NSDate date];
    self.reminderDatePicker.minimumDate = [NSDate date];
}

- (void) viewDidDisappear:(BOOL)animated
{
    self.prayer.title = self.titleTextField.text;
    self.prayer.remind_at = self.reminderDatePicker.date;
    
    [[PrayerCoreData sharedPrayerData] save];
    
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark TextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
