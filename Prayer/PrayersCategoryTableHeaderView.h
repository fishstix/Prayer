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
    BOOL _deleting;
    
    UILabel *_categoryLabel;
    UIButton *_addPrayerButton;
    UIButton *_deleteCategoryButton;
    UIButton *_toggleDeleteCategoryButton;
}

@property (nonatomic, assign) BOOL editing;
@property (nonatomic, assign) BOOL deleting;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain) IBOutlet UIButton *addPrayerButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteCategoryButton;
@property (nonatomic, retain) IBOutlet UIButton *toggleDeleteCategoryButton;

- (id) initWithFrame:(CGRect)frame Category:(NSString*)category;

- (IBAction)addPrayer:(id)sender;
- (IBAction)deleteCategory:(id)sender;
- (IBAction)toggleDeleteCategory:(id)sender;

@end
