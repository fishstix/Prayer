//
//  AddPrayerCategoryView.m
//  Prayer
//
//  Created by Charles Fisher on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddPrayerCategoryView.h"

#import "PrayerCategory.h"

@implementation AddPrayerCategoryView

@synthesize categoryTextField = _categoryTextField;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"AddPrayerCategoryView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];
        
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"AddPrayerCategoryView" owner:self options:nil];
        [self addSubview:[nibViews objectAtIndex:0]];
        
    }
    
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void) viewDidAppear
{
    [self.categoryTextField becomeFirstResponder];
}

- (void) viewDidDisappear
{
    [self.categoryTextField resignFirstResponder];
}


#pragma mark -
#pragma mark Logic

- (IBAction)addCategory:(id)sender
{
    NSString *newCategory = self.categoryTextField.text;
    
    if (newCategory == nil || [newCategory isEqualToString:@""]) {
        return;
    }

    self.categoryTextField.text = @"";
    
    if ([[PrayerCategory getCategories] containsObject:newCategory]) {
        return;
    }
    
    [PrayerCategory addCategory:newCategory];
    
    [self.categoryTextField resignFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField 
{
    [self addCategory:nil];
    
    return YES;
}

@end
