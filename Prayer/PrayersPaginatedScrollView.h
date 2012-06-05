//
//  PrayersPaginatedScrollView.h
//  Prayer
//
//  Created by Charles Fisher on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrayersPaginatedScrollView : UIView {
    
    UIScrollView *_scrollView;
    
    NSMutableArray *_tableViews;
    
    int _currentPage;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *tableViews;
@property (nonatomic, assign) int currentPage;

@end
