//
//  UIDateTextField.m
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "UIDateTextField.h"

#import <QuartzCore/QuartzCore.h>

@interface UIDateTextFieldDelegate : NSObject <UITextFieldDelegate> {
@private
    UIDateTextField *_parent;
    id<UITextFieldDelegate> _delegate;
}

@property (nonatomic, retain) UIDateTextField *parent;
@property (nonatomic, retain) id<UITextFieldDelegate> delegate;

@end

@implementation UIDateTextFieldDelegate

@synthesize parent = _parent;
@synthesize delegate = _delegate;

#pragma mark Delegate Methods

// Begin
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing::)]) {
        return [self.delegate textFieldShouldBeginEditing:(UITextField*)self.parent];
    }
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:(UITextField*)self.parent];
    }
    
    self.parent.layer.borderColor = [[UIColor darkGrayColor] CGColor];
}

// End
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:(UITextField*)self.parent];
    }
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:(UITextField*)self.parent];
    }
    
    self.parent.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

// Edit
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:(UITextField*)self.parent shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:(UITextField*)self.parent];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:(UITextField*)self.parent];
    }
    return YES;
}


@end




@interface UIDateTextField()

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UITextView *dateTextView;
@property (nonatomic, retain) id<UITextFieldDelegate> dateDelegate;

- (void) initialize;

- (void) datePickerValueChanged:(id)sender;
@end

@implementation UIDateTextField

@synthesize datePicker = _datePicker;
@synthesize dateTextView = _dateTextView;
@synthesize dateTextField = _dateTextField;
@synthesize dateDelegate = _dateDelegate;

@dynamic date;
@dynamic text;
@dynamic delegate;
@dynamic datePickerMode;

- (NSDate*) date {
    return self.datePicker.date;
}

- (void) setDate:(NSDate *)date {
    if (date != nil) {
        [self.datePicker setDate:date];
        [self datePickerValueChanged:self.datePicker];
    }
}

- (id<UITextFieldDelegate>) delegate {
    return ((UIDateTextFieldDelegate*)self.dateTextField.delegate).delegate;
}

- (void) setDelegate:(id<UITextFieldDelegate>)delegate {
    ((UIDateTextFieldDelegate*)self.dateTextField.delegate).delegate = delegate;
}

- (NSString*) text {
    return @"";
}

- (void) setText:(NSString *)text {
    //
}

- (void) setTag:(NSInteger)tag {
    super.tag = tag;
    self.dateTextField.tag = tag;
}

- (UIDatePickerMode) datePickerMode
{
    return self.datePicker.datePickerMode;
}

- (void) setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    self.datePicker.datePickerMode = datePickerMode;
}

#pragma mark - Init

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - CUSTOM

- (void) initialize {
    // Input
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker setDate:[NSDate date]];
//    [self.datePicker setMaximumDate:[NSDate date]];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // Acutal Input
    self.dateDelegate = [[UIDateTextFieldDelegate alloc] init];
    ((UIDateTextFieldDelegate*)self.dateDelegate).parent = self;
    
    self.dateTextField = [[UITextField alloc] init];
    [self.dateTextField setInputView:self.datePicker];
    [self.dateTextField setDelegate:self.dateDelegate];
    [self addSubview:self.dateTextField];
    
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Overlay
    self.dateTextView = [[UITextView alloc] initWithFrame:self.frame];
    [self.dateTextView setFrame:CGRectMake(0, -5, self.dateTextView.frame.size.width, 30)];
    [self.dateTextView setUserInteractionEnabled:NO];
    [self.dateTextView setFont:[UIFont systemFontOfSize:16]];
    [self.dateTextView setBackgroundColor:[UIColor whiteColor]];
    [self.dateTextView setTextAlignment:UITextAlignmentRight];
    [self.dateTextView setScrollEnabled:NO];
    [self addSubview:self.dateTextView];
    
    UIButton *firstResponderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstResponderButton setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [firstResponderButton addTarget:self action:@selector(becomeFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstResponderButton];
    
    // Border
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void) datePickerValueChanged:(id)sender {
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    
    NSDate *date = datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: self.datePickerMode == UIDatePickerModeDate ? @"MMM dd, yyyy" : @"MMM dd, hh:mm"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    self.dateTextView.text = dateString;
}

- (BOOL) becomeFirstResponder {
    return [self.dateTextField becomeFirstResponder];
}

@end
