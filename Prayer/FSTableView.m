//
//  FSTableView.m
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FSTableView.h"

@implementation FSTableView

@dynamic tableHeaderSuperView;

#define kHeaderSuperViewTag 45632

- (void) setTableHeaderSuperView:(UIView *)tableHeaderSuperView
{
    UIView *headerView = [self tableHeaderView];
    
    // Hidden
    [tableHeaderSuperView setFrame:CGRectMake(0, - tableHeaderSuperView.frame.size.height, tableHeaderSuperView.frame.size.width, tableHeaderSuperView.frame.size.height)];
    // Tagged
    [tableHeaderSuperView setTag:kHeaderSuperViewTag];
    
    if (headerView) {
        // Remove previous header
        UIView *previousSuper = [headerView viewWithTag:kHeaderSuperViewTag];
        if (previousSuper) {
            [previousSuper removeFromSuperview];
        }
        
        // New Super
        int height = headerView.frame.size.height;
        [headerView addSubview:tableHeaderSuperView];
        
        [headerView setFrame:CGRectMake(0, - tableHeaderSuperView.frame.size.height, headerView.frame.size.width, tableHeaderSuperView.frame.size.height + height)];
    } else {
        headerView = tableHeaderSuperView;
    }
    
    [self setTableHeaderView:headerView];
}

@end
