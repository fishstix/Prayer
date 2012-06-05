//
//  UIPickerTextField.h
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPickerTextField : UIView {
@private
    UIPickerView *_picker;
    UITextView *_pickerTextView;
    UITextField *_pickerTextField;
    
    NSArray *_pickerValues;
    
    id<UITextFieldDelegate> _pickerDelegate;
}

@property (nonatomic, retain) UITextField *pickerTextField;
@property (nonatomic, retain) NSArray *pickerValues;


@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) IBOutlet id<UITextFieldDelegate> delegate;

- (void) initialize;

@end
