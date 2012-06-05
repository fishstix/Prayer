//
//  PrayersCategoryTableHeaderView.h
//  Prayer
//
//  Created by Charles Fisher on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrayersCategoryTableHeaderView : UIView {
    UILabel *_categoryLabel;
}

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;

- (id) initWithFrame:(CGRect)frame Category:(NSString*)category;

- (IBAction)addPrayer:(id)sender;

@end
