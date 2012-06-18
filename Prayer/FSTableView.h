//
//  FSTableView.h
//  Prayer
//
//  Created by Charles Fisher on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSTableHeaderSuperView.h"

@interface FSTableView : UITableView
{
    BOOL _superVisible;
    int _headerSuperHeight;
}

/**
 *  Hidden View, visible after scroll
 */
@property (nonatomic, retain) FSTableHeaderSuperView* tableHeaderSuperView;

@end
