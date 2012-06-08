//
//  AddPrayerCategoryView.h
//  Prayer
//
//  Created by Charles Fisher on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppView.h"

@interface AddPrayerCategoryView : AppView <UITextFieldDelegate>
{
    UITextField *_categoryTextField;
}

@property (nonatomic, retain) IBOutlet UITextField *categoryTextField;

- (IBAction)addCategory:(id)sender;

@end
