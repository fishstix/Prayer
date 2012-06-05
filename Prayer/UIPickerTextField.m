//
//  UIPickerTextField.m
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 FishStix. All rights reserved.
//

#import "UIPickerTextField.h"

#import <QuartzCore/QuartzCore.h>

@interface UIPickerTextFieldDelegate : NSObject <UITextFieldDelegate> {
@private
    UIPickerTextField *_parent;
    id<UITextFieldDelegate> _delegate;
}

@property (nonatomic, retain) UIPickerTextField *parent;
@property (nonatomic, retain) id<UITextFieldDelegate> delegate;

@end

@implementation UIPickerTextFieldDelegate

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




@interface UIPickerTextField() <UIPickerViewDataSource>

@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UITextView *pickerTextView;
@property (nonatomic, retain) id<UITextFieldDelegate> pickerDelegate;

- (void) pickerValueChanged:(id)sender;
@end

@implementation UIPickerTextField

@synthesize picker = _picker;
@synthesize pickerTextView = _pickerTextView;
@synthesize pickerTextField = _pickerTextField;
@synthesize pickerDelegate = _pickerDelegate;

@synthesize pickerValues = _pickerValues;

@dynamic text;
@dynamic delegate;

- (id<UITextFieldDelegate>) delegate {
    return ((UIPickerTextFieldDelegate*)self.pickerTextField.delegate).delegate;
}

- (void) setDelegate:(id<UITextFieldDelegate>)delegate {
    ((UIPickerTextFieldDelegate*)self.pickerTextField.delegate).delegate = delegate;
}

- (NSString*) text {
    return self.pickerTextView.text;
}

- (void) setText:(NSString *)text {
    //
    int index = [self.pickerValues indexOfObject:text];
    if (index != NSNotFound) {
        [self.picker selectRow:index inComponent:0 animated:NO];
    }
    
    [self.pickerTextView setText:text];
}

- (void) setTag:(NSInteger)tag {
    super.tag = tag;
    self.pickerTextField.tag = tag;
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
    self.picker = [[UIPickerView alloc] init];
    
    // Acutal Input
    self.pickerDelegate = [[UIPickerTextFieldDelegate alloc] init];
    ((UIPickerTextFieldDelegate*)self.pickerDelegate).parent = self;
    
    self.pickerTextField = [[UITextField alloc] init];
    [self.pickerTextField setInputView:self.picker];
    [self.pickerTextField setDelegate:self.pickerDelegate];
    [self addSubview:self.pickerTextField];
    
    self.picker.delegate = self;
    self.picker.dataSource = self;
//    [self.picker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Overlay
    self.pickerTextView = [[UITextView alloc] initWithFrame:self.frame];
    [self.pickerTextView setFrame:CGRectMake(0, -5, self.pickerTextView.frame.size.width, 30)];
    [self.pickerTextView setUserInteractionEnabled:NO];
    [self.pickerTextView setFont:[UIFont systemFontOfSize:16]];
    [self.pickerTextView setBackgroundColor:[UIColor whiteColor]];
    [self.pickerTextView setTextAlignment:UITextAlignmentRight];
    [self.pickerTextView setScrollEnabled:NO];
    [self addSubview:self.pickerTextView];
    
    UIButton *firstResponderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstResponderButton setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [firstResponderButton addTarget:self action:@selector(becomeFirstResponder) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstResponderButton];
    
    self.pickerValues = [NSArray array];
    
    // Border
    self.layer.borderWidth = 2.0f;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (BOOL) becomeFirstResponder {
    return [self.pickerTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void) pickerView:(id)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     self.pickerTextView.text = [self.pickerValues objectAtIndex:row];
}

- (NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerValues objectAtIndex:row];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerValues count];
}

@end
