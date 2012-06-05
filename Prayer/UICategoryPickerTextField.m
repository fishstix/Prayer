//
//  UICategoryPickerTextField.m
//  Prayer
//
//  Created by Charles Fisher on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UICategoryPickerTextField.h"
#import "PrayerCategory.h"

@implementation UICategoryPickerTextField

- (void) initialize
{
    [super initialize];
    
    self.pickerValues = [PrayerCategory getCategories];
}

@end
