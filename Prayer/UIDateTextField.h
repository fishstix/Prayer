//
//  UIDateTextField.h
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDateTextField : UIView {
@private
    UIDatePicker *_datePicker;
    UITextView *_dateTextView;
    UITextField *_dateTextField;
    
    id<UITextFieldDelegate> _dateDelegate;
}

@property (nonatomic, retain) UITextField *dateTextField;

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) IBOutlet id<UITextFieldDelegate> delegate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;

@end
