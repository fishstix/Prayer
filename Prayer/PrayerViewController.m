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
@synthesize datePicker = _datePicker;
@synthesize repeatPicker = _repeatPicker;
@synthesize categoryPicker = _categoryPicker;

@synthesize prayer = _prayer;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleTextField.text = self.prayer.title;
    
#warning Go back to 30 minutes
//    self.reminderDatePicker.minuteInterval = 30;
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.date = self.prayer.remind_at ? self.prayer.remind_at : [NSDate date];
//    self.reminderDatePicker.minimumDate = [NSDate date];
    self.repeatPicker.repeatInterval = (NSCalendarUnit) self.prayer.recure;
    [self.categoryPicker setText:self.prayer.category];
}

- (void) viewDidDisappear:(BOOL)animated
{
    self.prayer.title = self.titleTextField.text;
    self.prayer.remind_at = self.datePicker.date;
    self.prayer.recure = self.repeatPicker.repeatInterval;
    self.prayer.category = self.categoryPicker.text;
    
    [[PrayerCoreData sharedPrayerData] updatePrayer:self.prayer];
    
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
