//
//  UIRepeatPickerTextField.m
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIRepeatPickerTextField.h"

@implementation UIRepeatPickerTextField

- (void) initialize
{
    [super initialize];
    
    self.pickerValues = [NSArray arrayWithObjects:@"None", @"Daily", @"Weekly", @"Monthly", @"Annually", nil];
}

@end
