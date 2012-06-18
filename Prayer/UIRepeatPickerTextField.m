//
//  UIRepeatPickerTextField.m
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIRepeatPickerTextField.h"

#define kNone @"None"
#define kDaily @"Daily"
#define kWeekly @"Weekly"
#define kMonthly @"Monthly"
#define kAnnually @"Annually"

@implementation UIRepeatPickerTextField

@dynamic repeatInterval;

- (void) initialize
{
    [super initialize];
    
    self.pickerValues = [NSArray arrayWithObjects:kNone, kDaily, kWeekly, kMonthly, kAnnually, nil];
}

#pragma mark -
#pragma mark Repeat

- (void) setRepeatInterval:(NSCalendarUnit)repeatInterval
{
    switch (repeatInterval) {
        case NSDayCalendarUnit:
            [self setText:kDaily];
            break;
        case NSWeekCalendarUnit:
            [self setText:kWeekly];
            break;
        case NSMonthCalendarUnit:
            [self setText:kMonthly];
            break;
        case NSYearCalendarUnit:
            [self setText:kAnnually];
            break;
        default:
            [self setText:kNone];
            break;
    }
}

- (NSCalendarUnit) repeatInterval
{
    if ([self.text isEqualToString:kDaily]) {
        return NSDayCalendarUnit;
    } else if ([self.text isEqualToString:kWeekly]) {
        return NSWeekCalendarUnit;
    } else if ([self.text isEqualToString:kMonthly]) {
        return NSMonthCalendarUnit;
    } else if ([self.text isEqualToString:kAnnually]) {
        return NSYearCalendarUnit;
    } else {
        return nil;
    }
}

@end
