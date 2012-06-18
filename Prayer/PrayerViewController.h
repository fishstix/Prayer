//
//  PrayerViewController.h
//  Prayer
//
//  Created by Charles Fisher on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppViewController.h"

#import "UIDateTextField.h"
#import "UIRepeatPickerTextField.h"
#import "UICategoryPickerTextField.h"

#import "Prayer.h"

@interface PrayerViewController : AppViewController <UITextFieldDelegate> {
    UITextField *_titleTextField;
    UIDateTextField *_datePicker;
    UIRepeatPickerTextField *_repeatPicker;
    UICategoryPickerTextField *_categoryPicker;
    
    Prayer *_prayer;
}

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UIDateTextField *datePicker;
@property (nonatomic, retain) IBOutlet UIRepeatPickerTextField *repeatPicker;
@property (nonatomic, retain) IBOutlet UICategoryPickerTextField *categoryPicker;

@property (nonatomic, retain) Prayer *prayer;

@end
