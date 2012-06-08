//
//  PrayersCategoryTableHeaderView.h
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrayersCategoryTableHeaderView : UIView {
    BOOL _editing;
    
    UILabel *_categoryLabel;
    UIButton *_addPrayerButton;
    UIButton *_deleteCategoryButton;
}

@property (nonatomic, assign) BOOL editing;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain) IBOutlet UIButton *addPrayerButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteCategoryButton;

- (id) initWithFrame:(CGRect)frame Category:(NSString*)category;

- (IBAction)addPrayer:(id)sender;
- (IBAction)deleteCategory:(id)sender;

@end
