//
//  PrayerViewController.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppViewController.h"

#import "Prayer.h"

@interface PrayerViewController : AppViewController <UITextFieldDelegate> {
    UITextField *_titleTextField;
    UIDatePicker *_reminderDatePicker;
    
    Prayer *_prayer;
}

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UIDatePicker *reminderDatePicker;

@property (nonatomic, retain) Prayer *prayer;

@end
